ICU_CFLAGS = `icu-config --cppflags-searchpath`
ICU_LDFLAGS = `icu-config --ldflags`
PG_INCLUDE_DIR = `pg_config --includedir-server`
PG_PKG_LIB_DIR = `pg_config --pkglibdir`

collkey_icu.so: collkey_icu.o
	ld -shared -o collkey_icu.so collkey_icu.o $(ICU_LDFLAGS)

collkey_icu.o: collkey_icu.c
	gcc -Wall -fPIC $(ICU_CFLAGS) -I $(PG_INCLUDE_DIR) -o collkey_icu.o -c collkey_icu.c

clean:
	rm -f *.o *.so

install:
	install collkey_icu.so $(PG_PKG_LIB_DIR)
