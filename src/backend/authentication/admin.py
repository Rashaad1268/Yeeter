from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.utils.translation import gettext_lazy as _

from . import models


@admin.register(models.User)
class CustomUserAdmin(UserAdmin):
    fieldsets = (
        (None, {"fields": ("username", "password")}),
        (_("Personal info"), {"fields": ("first_name", "last_name", "handle", "email")}),
        (
            _("Permissions"),
            {
                "fields": (
                    "is_active",
                    "is_staff",
                    "is_superuser",
                    "groups",
                    "user_permissions",
                ),
            },
        ),
        (_("Important dates"), {"fields": ("last_login", "date_joined")}),
        (_("Status"), {"fields": ("is_online",)}),
    )
    add_fieldsets = (
        (
            None,
            {
                "classes": ("wide",),
                "fields": ("username", "email", "handle", "password1", "password2"),
            },
        ),
    )
    list_display = ("username", "email", "handle", "is_staff")


@admin.register(models.Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = ('user',)


@admin.register(models.UserRelations)
class UserRelationsAdmin(admin.ModelAdmin):...
#     list_display = ('user_rel', '', 'type')
