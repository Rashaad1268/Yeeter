from rest_framework.routers import DefaultRouter

from . import views


router = DefaultRouter()
router.register("", views.PostsViewSet, basename="posts")

urlpatterns = router.urls
