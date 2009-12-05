/* gui_image.c - GUI component to display an image.  */
/*
 *  GRUB  --  GRand Unified Bootloader
 *  Copyright (C) 2008,2009  Free Software Foundation, Inc.
 *
 *  GRUB is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  GRUB is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with GRUB.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <grub/mm.h>
#include <grub/misc.h>
#include <grub/gui.h>
#include <grub/gui_string_util.h>
#include <grub/bitmap.h>
#include <grub/bitmap_scale.h>

struct grub_gui_image
{
  struct grub_gui_component_ops *image;

  grub_gui_container_t parent;
  grub_video_rect_t bounds;
  char *id;
  int preferred_width;
  int preferred_height;
  struct grub_video_bitmap *raw_bitmap;
  struct grub_video_bitmap *bitmap;
};

typedef struct grub_gui_image *grub_gui_image_t;

static void
image_destroy (void *vself)
{
  grub_gui_image_t self = vself;

  /* Free the scaled bitmap, unless it's a reference to the raw bitmap.  */
  if (self->bitmap && (self->bitmap != self->raw_bitmap))
    grub_video_bitmap_destroy (self->bitmap);
  if (self->raw_bitmap)
    grub_video_bitmap_destroy (self->raw_bitmap);

  grub_free (self);
}

static const char *
image_get_id (void *vself)
{
  grub_gui_image_t self = vself;
  return self->id;
}

static int
image_is_instance (void *vself __attribute__((unused)), const char *type)
{
  return grub_strcmp (type, "component") == 0;
}

static void
image_paint (void *vself, const grub_video_rect_t *region)
{
  grub_gui_image_t self = vself;
  grub_video_rect_t vpsave;

  if (! self->bitmap)
    return;
  if (!grub_video_have_common_points (region, &self->bounds))
    return;

  grub_gui_set_viewport (&self->bounds, &vpsave);
  grub_video_blit_bitmap (self->bitmap, GRUB_VIDEO_BLIT_BLEND,
                          0, 0, 0, 0,
                          grub_video_bitmap_get_width (self->bitmap),
                          grub_video_bitmap_get_height (self->bitmap));
  grub_gui_restore_viewport (&vpsave);
}

static void
image_set_parent (void *vself, grub_gui_container_t parent)
{
  grub_gui_image_t self = vself;
  self->parent = parent;
}

static grub_gui_container_t
image_get_parent (void *vself)
{
  grub_gui_image_t self = vself;
  return self->parent;
}

static grub_err_t
rescale_image (grub_gui_image_t self)
{
  if (! self->raw_bitmap)
    {
      if (self->bitmap)
        {
          grub_video_bitmap_destroy (self->bitmap);
          self->bitmap = 0;
        }
      return grub_errno;
    }

  unsigned width = self->bounds.width;
  unsigned height = self->bounds.height;

  if (self->bitmap
      && (grub_video_bitmap_get_width (self->bitmap) == width)
      && (grub_video_bitmap_get_height (self->bitmap) == height))
    {
      /* Nothing to do; already the right size.  */
      return grub_errno;
    }

  /* Free any old scaled bitmap,
     *unless* it's a reference to the raw bitmap.  */
  if (self->bitmap && (self->bitmap != self->raw_bitmap))
    grub_video_bitmap_destroy (self->bitmap);

  self->bitmap = 0;

  /* Create a scaled bitmap, unless the requested size is the same
     as the raw size -- in that case a reference is made.  */
  if (grub_video_bitmap_get_width (self->raw_bitmap) == width
      && grub_video_bitmap_get_height (self->raw_bitmap) == height)
    {
      self->bitmap = self->raw_bitmap;
      return grub_errno;
    }

  /* Don't scale to an invalid size.  */
  if (width == 0 || height == 0)
    return grub_errno;

  /* Create the scaled bitmap.  */
  grub_video_bitmap_create_scaled (&self->bitmap,
                                   width,
                                   height,
                                   self->raw_bitmap,
                                   GRUB_VIDEO_BITMAP_SCALE_METHOD_BEST);
  if (grub_errno != GRUB_ERR_NONE)
    {
      grub_error_push ();
      grub_error (grub_errno, "failed to scale bitmap for image component");
    }
  return grub_errno;
}

static void
image_set_bounds (void *vself, const grub_video_rect_t *bounds)
{
  grub_gui_image_t self = vself;
  self->bounds = *bounds;
  rescale_image (self);
}

static void
image_get_bounds (void *vself, grub_video_rect_t *bounds)
{
  grub_gui_image_t self = vself;
  *bounds = self->bounds;
}

static void
image_get_preferred_size (void *vself, int *width, int *height)
{
  grub_gui_image_t self = vself;

  if (self->raw_bitmap)
    {
      *width = grub_video_bitmap_get_width (self->raw_bitmap);
      *height = grub_video_bitmap_get_height (self->raw_bitmap);
    }
  else
    {
      *width = 0;
      *height = 0;
    }

  /* Allow preferred dimensions to override the image dimensions.  */
  if (self->preferred_width >= 0)
    *width = self->preferred_width;
  if (self->preferred_height >= 0)
    *height = self->preferred_height;
}

static grub_err_t
load_image (grub_gui_image_t self, const char *path)
{
  struct grub_video_bitmap *bitmap;
  if (grub_video_bitmap_load (&bitmap, path) != GRUB_ERR_NONE)
    return grub_errno;

  if (self->bitmap && (self->bitmap != self->raw_bitmap))
    grub_video_bitmap_destroy (self->bitmap);
  if (self->raw_bitmap)
    grub_video_bitmap_destroy (self->raw_bitmap);

  self->raw_bitmap = bitmap;
  return rescale_image (self);
}

static grub_err_t
image_set_property (void *vself, const char *name, const char *value)
{
  grub_gui_image_t self = vself;
  if (grub_strcmp (name, "file") == 0)
    return load_image (self, value);
  else if (grub_strcmp (name, "preferred_size") == 0)
    {
      int w;
      int h;
      if (grub_gui_parse_2_tuple (value, &w, &h) != GRUB_ERR_NONE)
        return grub_errno;
      self->preferred_width = w;
      self->preferred_height = h;
    }
  else if (grub_strcmp (name, "id") == 0)
    {
      grub_free (self->id);
      if (value)
        self->id = grub_strdup (value);
      else
        self->id = 0;
    }
  return grub_errno;
}

static struct grub_gui_component_ops image_ops =
{
  .destroy = image_destroy,
  .get_id = image_get_id,
  .is_instance = image_is_instance,
  .paint = image_paint,
  .set_parent = image_set_parent,
  .get_parent = image_get_parent,
  .set_bounds = image_set_bounds,
  .get_bounds = image_get_bounds,
  .get_preferred_size = image_get_preferred_size,
  .set_property = image_set_property
};

grub_gui_component_t
grub_gui_image_new (void)
{
  grub_gui_image_t image;
  image = grub_malloc (sizeof (*image));
  if (! image)
    return 0;
  image->image = &image_ops;
  image->parent = 0;
  image->bounds.x = 0;
  image->bounds.y = 0;
  image->bounds.width = 0;
  image->bounds.height = 0;
  image->id = 0;
  image->preferred_width = -1;
  image->preferred_height = -1;
  image->raw_bitmap = 0;
  image->bitmap = 0;
  return (grub_gui_component_t) image;
}
