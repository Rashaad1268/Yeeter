from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import pagination, status, viewsets
from rest_framework.decorators import action
from rest_framework.generics import get_object_or_404
from rest_framework.response import Response

from posts.models import Post
from posts.serializers import PostCreateSerializer, PostSerializer


class PostsPaginator(pagination.PageNumberPagination):
    page_size = 30


class PostsViewSet(viewsets.ModelViewSet):
    pagination_class = PostsPaginator
    filter_backends = (DjangoFilterBackend,)
    filterset_fields = ("author", "body", "created_at", "edited_at")

    def get_queryset(self):
        if self.action == "list" and not self.request.GET:
            return Post.objects.all().order_by("?")
        else:
            return Post.objects.all().order_by("-created_at")

    def get_serializer_class(self):
        if self.action.lower() in ("create", "partial_update", "update", "delete"):
            return PostCreateSerializer
        else:
            return PostSerializer

    @action(methods=("POST",), detail=True, url_path='like')
    def like_post(self, request, pk):
        post = get_object_or_404(Post, pk=pk)
        is_liked = post.likes.contains(request.user)

        if is_liked:
            post.likes.remove(request.user)
        else:
            post.likes.add(request.user)

        return Response(status=status.HTTP_204_NO_CONTENT)
    
    @action(methods=("POST",), detail=True, url_path='re-post')
    def re_post(self, request, pk):
        post = get_object_or_404(Post, pk=pk)
        new_post = Post.objects.create(author=request.user, re_post=post)

        return Response(PostSerializer(new_post, context=self.get_serializer_context()).data,
                        status=status.HTTP_201_CREATED)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        post = serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(PostSerializer(post, context=self.get_serializer_context()).data,
                        status=status.HTTP_201_CREATED, headers=headers)
