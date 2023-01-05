# Issue

There appears to be some sort of incompatiblity between pyodbc, unixodbc, connection pooling,
and long connection strings.

I'm really unsure where to start. You can reproduce this by running:

docker run jabberaa/spark-odbc-issue:latest

Here is the stack trace

```
**1** *** memmove_chk: buffer overflow detected ***: program terminated
==1==    at 0x484E7CC: ??? (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1==    by 0x4853323: __memmove_chk (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
==1==    by 0x531B54B: search_for_pool (in /opt/conda/lib/libodbc.so.2.0.0)
==1==    by 0x533AB3E: SQLDriverConnectW (in /opt/conda/lib/libodbc.so.2.0.0)
==1==    by 0x52EC8E2: Connect (connection.cpp:114)
==1==    by 0x52EC8E2: Connection_New(_object*, bool, bool, long, bool, _object*, Object&) (connection.cpp:286)
==1==    by 0x52F6D7F: mod_connect(_object*, _object*, _object*) (pyodbcmodule.cpp:553)
==1==    by 0x4FE1A6: cfunction_call (methodobject.c:543)
==1==    by 0x4F7B8A: _PyObject_MakeTpCall (call.c:215)
==1==    by 0x4F428C: UnknownInlinedFun (abstract.h:112)
==1==    by 0x4F428C: UnknownInlinedFun (abstract.h:99)
==1==    by 0x4F428C: UnknownInlinedFun (abstract.h:123)
==1==    by 0x4F428C: UnknownInlinedFun (ceval.c:5891)
==1==    by 0x4F428C: _PyEval_EvalFrameDefault (ceval.c:4231)
==1==    by 0x594B71: UnknownInlinedFun (pycore_ceval.h:46)
==1==    by 0x594B71: _PyEval_Vector (ceval.c:5065)
==1==    by 0x594AB6: PyEval_EvalCode (ceval.c:1134)
==1==    by 0x5C6E56: run_eval_code_obj (pythonrun.c:1291)
```