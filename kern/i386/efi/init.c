/* init.c - initialize an x86-based EFI system */
/*
 *  GRUB  --  GRand Unified Bootloader
 *  Copyright (C) 2006,2007  Free Software Foundation, Inc.
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

#include <grub/types.h>
#include <grub/misc.h>
#include <grub/mm.h>
#include <grub/err.h>
#include <grub/dl.h>
#include <grub/cache.h>
#include <grub/kernel.h>
#include <grub/efi/efi.h>
#include <grub/time.h>

void
grub_millisleep (grub_uint32_t ms)
{
  grub_millisleep_generic (ms);
}

void
grub_machine_init (void)
{
  grub_efi_init ();
}

void
grub_machine_fini (void)
{
  grub_efi_fini ();
}

void
grub_machine_set_prefix (void)
{
  grub_efi_set_prefix ();
}

void
grub_arch_sync_caches (void *address __attribute__ ((unused)),
                       grub_size_t len __attribute__ ((unused)))
{
}
