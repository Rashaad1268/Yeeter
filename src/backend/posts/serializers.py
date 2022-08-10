from authentication.serializers import UserSerializer
from rest_framework import serializers

from posts import models


class PostCreateSerializer(serializers.ModelSerializer):
    body = serializers.CharField(max_length=1000, allow_blank=False)
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
    re_post = serializers.SerializerMethodField()
    quoting = QuotedPostSerializer()
    like_count = serializers.SerializerMethodField()
    re_post_count = serializers.SerializerMethodField()
    is_liked = serializers.SerializerMethodField()

    def get_like_count(self, post):
        return post.likes.all().count()

    def get_is_liked(self, post):
        return post.likes.contains(self.context['request'].user)

    def get_re_post_count(self, post):
        return post.re_posts.count()

    def get_re_post(self, post):
        if post.re_post != None:
            return PostSerializer(post.re_post, context=self.context).data

    class Meta(PostCreateSerializer.Meta):
        fields = ('id', 'author', 'body', 'quoting', 'created_at',
                  're_post', 're_post_count', 'edited_at', 'like_count',
                  'is_liked',)
