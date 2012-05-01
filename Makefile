icu_incdir = /usr/include
icu_libdir = /usr/lib

collkey_icu.so: collkey_icu.o
	ld -shared -o collkey_icu.so collkey_icu.o --rpath $(icu_libdir) \
		$(icu_libdir)/libicui18n.so

collkey_icu.o: collkey_icu.c
	gcc -Wall -fpic -c -I $(icu_incdir) \
		-I `pg_config --includedir-server` \
		-o collkey_icu.o collkey_icu.c

clean:
	rm -f *.o *.so

