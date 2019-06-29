/*
 * No copyright is claimed.  This code is in the public domain; do with
 * it what you wish.
 *
 * Written by Karel Zak <kzak@redhat.com>
 *            Petr Uzel <petr.uzel@suse.cz>
 */

#ifndef UTIL_LINUX_ALL_IO_H
#define UTIL_LINUX_ALL_IO_H

#include "c.h"

#include <string.h>
#if defined(_WIN32) || defined(_WIN64)
#	include <io.h>
#else
#	include <unistd.h>
#endif
#include <errno.h>

static inline int write_all(int fd, const void *buf, size_t count)
{
	while (count) {
		long long tmp;

		errno = 0;
		tmp = _write(fd, buf, (unsigned long)count);
		if (tmp > 0) {
			count -= (size_t)tmp;
			if (count)
				buf = (void *) ((char *) buf + (size_t)tmp);
		} else if (errno != EINTR && errno != EAGAIN)
			return -1;
		if (errno == EAGAIN)	/* Try later, *sigh* */
			usleep(10000);
	}
	return 0;
}

static inline int fwrite_all(const void *ptr, size_t size,
			     size_t nmemb, FILE *stream)
{
	while (nmemb) {
		size_t tmp;

		errno = 0;
		tmp = fwrite(ptr, size, nmemb, stream);
		if (tmp > 0) {
			nmemb -= (size_t)tmp;
			if (nmemb)
				ptr = (void *) ((char *) ptr + (((size_t)tmp) * size));
		} else if (errno != EINTR && errno != EAGAIN)
			return -1;
		if (errno == EAGAIN)	/* Try later, *sigh* */
			usleep(10000);
	}
	return 0;
}

static inline long long read_all(int fd, char *buf, size_t count)
{
	long long ret;
	long long c = 0;
	int tries = 0;

	memset(buf, 0, count);
	while (count > 0) {
		ret = _read(fd, buf, (unsigned long)count);
		if (ret <= 0) {
			if ((errno == EAGAIN || errno == EINTR || ret == 0) &&
			    (tries++ < 5))
				continue;
			return c ? c : -1;
		}
		if (ret > 0)
			tries = 0;
		count -= (size_t)ret;
		buf += ret;
		c += ret;
	}
	return c;
}


#endif /* UTIL_LINUX_ALL_IO_H */
