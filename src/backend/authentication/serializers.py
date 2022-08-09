from rest_framework import serializers
from django.contrib.auth import get_user_model

from .models import Profile, UserRelations


User = get_user_model()


class UserCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('username', 'email', 'handle', 'password')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, user_data):
        return User.objects.create_user(username=user_data['username'], email=user_data['email'],
                                        password=user_data['password'], handle=user_data['handle'])


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = ('about_me', 'profile_picture', 'banner_image')


class UserSerializer(UserCreateSerializer):
    password = None
    email = None
    profile = UserProfileSerializer()
    followers_count = serializers.SerializerMethodField()
    following_count = serializers.SerializerMethodField()
    is_following = serializers.SerializerMethodField()
    is_following_me = serializers.SerializerMethodField()

    def get_followers_count(self, user):
        return UserRelations.objects.filter(type=1, target=user).count()

    def get_following_count(self, user):
        return UserRelations.objects.filter(type=1, actor=user).count()

    def get_is_following(self, user):
        request = self.context['request']
        return UserRelations.objects.filter(type=1, actor=request.user,
                                            target=user).exists()

    def get_is_following_me(self, user):
        request = self.context['request']
        return UserRelations.objects.filter(type=1, actor=user,
                                            target=request.user).exists()

    class Meta(UserCreateSerializer.Meta):
        fields = ('id', 'username', 'handle', 'is_online', 'is_staff', 'profile',
                  'followers_count', 'following_count', 'is_following',
                  'is_following_me')


class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField()
