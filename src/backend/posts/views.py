from rest_framework import viewsets, pagination, status
from rest_framework.decorators import action
from rest_framework.generics import get_object_or_404
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response

from .serializers import PostCreateSerializer, PostSerializer
from .models import Post


class PostsPaginator(pagination.PageNumberPagination):
    page_size = 30


class PostsViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all().order_by('?')
    pagination_class = PostsPaginator
    filter_backends = (DjangoFilterBackend,)
    filterset_fields = ('author', 'body', 'created_at', 'edited_at')

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
