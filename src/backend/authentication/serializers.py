from rest_framework import serializers
from django.contrib.auth import get_user_model

from .models import Profile


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
        fields = ('about_me', 'profile_picture')


class UserSerializer(UserCreateSerializer):
    password = None
    email = None
    profile = UserProfileSerializer()

    class Meta(UserCreateSerializer.Meta):
        fields = ('id', 'username', 'handle', 'is_online', 'is_staff', 'profile')


class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField()
