from django.contrib.auth.models import AbstractUser
from django.contrib.auth.validators import UnicodeUsernameValidator
from django.db import models
from django.utils.translation import gettext_lazy as _


class UsernameValidator(UnicodeUsernameValidator):
    regex = r'^[\w.@+\- ]+$'
    message = _(
    "Enter a valid username. This value may contain only letters, "
    "numbers, whitespace, and @/./+/-/_ characters."
    )


class User(AbstractUser):
    username = models.CharField(
        _("username"),
        max_length=30,
        unique=True,
        help_text=_(
            "Required. 30 characters or fewer. Letters, digits, whitespace, and @/./+/-/_ only."
        ),
        validators=[UsernameValidator()],
        error_messages={
            "unique": _("A user with that username already exists."),
        },
    )
    email = models.EmailField("email address", unique=True, blank=False, null=False)
    handle = models.SlugField(max_length=15, unique=True)
    is_online = models.BooleanField(default=False)

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = ("username", "handle")


class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    about_me = models.TextField(max_length=500, null=True, blank=True)
    profile_picture = models.ImageField(upload_to="users/profile_pictures", null=True, blank=True)
    banner_image = models.ImageField(upload_to="users/banner_images", null=True, blank=True)


class UserRelations(models.Model):
    relation_types = (
        (1, "Following"),
        (2, "Blocked"),
    )
    actor = models.ForeignKey(User, on_delete=models.CASCADE, related_name="user_rels_actor")
    target = models.ForeignKey(User, on_delete=models.CASCADE, related_name="user_rels_target")
    type = models.IntegerField(choices=relation_types)

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=['actor', 'target'], name="unique user relation")
        ]
