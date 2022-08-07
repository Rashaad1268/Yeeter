from authentication.serializers import UserSerializer
from rest_framework import serializers

from posts import models


class PostCreateSerializer(serializers.ModelSerializer):
    author = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )

    class Meta:
        model = models.Post
        fields = ('author', 'body', 'quoting')


class QuotedPostSerializer(PostCreateSerializer):
    author = UserSerializer()

    class Meta(PostCreateSerializer.Meta):
        fields = ('id', 'author', 'body', 'created_at', 'edited_at')


class PostSerializer(PostCreateSerializer):
    author = UserSerializer()
    quoting = QuotedPostSerializer()
    like_count = serializers.SerializerMethodField()
    is_liked = serializers.SerializerMethodField()

    def get_like_count(self, post):
        return post.likes.all().count()

    def get_is_liked(self, post):
        return post.likes.contains(self.context['request'].user)

    class Meta(PostCreateSerializer.Meta):
        fields = ('id', 'author', 'body', 'quoting', 'created_at',
                  'edited_at', 'like_count', 'is_liked')
