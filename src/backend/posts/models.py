from django.db import models
from django.conf import settings
from django.utils import timezone


class Post(models.Model):
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    body = models.TextField(max_length=1000, null=True, blank=True)
    quoting = models.ForeignKey("self", on_delete=models.CASCADE, null=True, blank=True)
    re_post = models.ForeignKey("self", on_delete=models.CASCADE, null=True,
                                blank=True, related_name="re_posts")
    created_at = models.DateTimeField(auto_now_add=True)
    edited_at = models.DateTimeField(blank=True, null=True)
    likes = models.ManyToManyField(settings.AUTH_USER_MODEL, blank=True, related_name="post_likes")

    def save(self, *args, **kwargs):
        if not self._state.adding:
            self.edited_at = timezone.now()

        else:
            if self.re_post != None:
                assert not self.body, "Body can't be supplied in reposts"

        return super().save(*args, **kwargs)


class Reply(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    edited_at = models.DateTimeField(blank=True, null=True)
    reference = models.ForeignKey("self", on_delete=models.CASCADE, null=True, blank=True)

    def save(self, *args, **kwargs):
        if not self._state.adding:
            self.edited_at = timezone.now()

        return super().save(*args, **kwargs)
