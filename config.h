/*
    Copyright (C) 2012 - 2015 Andreas Baumann <mail@andreasbaumann.cc>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef CONFIG_H
#define CONFIG_H

/* version of PgFuse */

#define PGFUSE_VERSION		"0.0.1"

/* standard block size, that's the split size for the byta column in data */

#define DEFAULT_BLOCK_SIZE	4096

/* maximum length of a filename , rather arbitrary choice */

#define MAX_FILENAME_LENGTH	4096

/* maximum number of open database connections */

#define MAX_DB_CONNECTIONS	8

/* maximum number of tablespaces, used for free blocks calculation */

#define MAX_TABLESPACE_OIDS	16

/* location of the mtab file of mounted filesystems */

#define MTAB_FILE		"/etc/mtab"

/* size of buffer for mtab traversal */

#define MTAB_BUFFER_SIZE	4096

#endif
