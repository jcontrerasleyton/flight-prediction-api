# Cloud based flight delay prediction API

## Stress Test

[WRK](https://github.com/wg/wrk) was used to stress test the Prediction API. WRK is an HTTP benchmarking tool capable of generating massive traffic in a certain time window from a single multi-core cpu.

The test was performed from a Desktop CPU, with 8GB of Memory, an Intel Core i5 3570 CPU with 4 cores and Windows 10 Pro O.S.

| Test | Connections | Requests | Requests/sec | Error connection | Error read | Error write | Error timeout | Latency (ms)  | Stdev (ms) | Max latency (ms) | Stdev (+/-) |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 10 | 2186 | 48,52 | 0 | 0 | 0 | 0 | 165,24 | 38,97 | 520,7 | 96,01 |
| 2 | 50 | 13463 | 298,65 | 0 | 0 | 0 | 0 | 160 | 11,84 | 432 | 96,83 |
| 3 | 100 | 27824 | 617,69 | 0 | 0 | 0 | 9 | 160,17 | 13,67 | 606,68 | 97,32 |
| 4 | 200 | 50279 | 1115,46 | 0 | 0 | 0 | 14 | 177,54 | 40,05 | 799,02 | 87,24 |
| 5 | 400 | 90136 | 1999,18 | 0 | 0 | 0 | 0 | 198,05 | 61,66 | 976,01 | 83,85 |
| 6 | 800 | 147445 | 3272,31 | 0 | 0 | 0 | 803 | 228,29 | 124,76 | 2000 | 92,28 |
| 7 | 1600 | 164437 | 3648,79 | 583 | 0 | 0 | 1483 | 243,74 | 75,39 | 1670 | 62,2 |

The table above shows that as the number of connections doubles, the number of requests also increases, but by a smaller percentage as there are more connections, from a 515% increase in test 2 to an 11% increase in test 7 (compared to the previous test).

It can also be seen that the highest percentage of errors is 1.26% in test 7, this value increases a measure that there is a greater number of connections (with an increase in errors of 13% in test 4 and 130% in test 7.

Regarding the average latency, this also increases as there are more connections, however, the increase is very limited, from a decrease of 3% in test 2 to an increase of 15% in test 7 (compared to previous test).

If we compare the number of connections between test 1 and test 7 there is an increase of 7422%, while the increase in latency is only 47%, this means that Cloud Run gives us a reliability and scalability platform that adapts seamlessly to changes in workload.

In average, the time that is use to get the json input, transform it to a numpy array and the model prediction is 1.68ms, this means that the latency depends in the connection to the Cloud Service and the machine running this tests, in order to get better performance a machine with better CPU specifications is required. 

Also, it would be worthy to carry out an analysis of the different frameworks and servers offered to expose APIs, carry out tests with the most recommended ones and choose the best one based on the one with the lowest latency.

### 

---

## WRK Tests in Detail

The following are the detaills for the 7 tests in WRK:

### Test 1

Configuration: 45 seconds, 4 Threads and 10 Connections

```
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   165.24ms   38.97ms 520.70ms   96.01%
    Req/Sec    12.56      4.73    20.00     68.44%
  2186 requests in 45.05s, 0.85MB read
Requests/sec:     48.52
Transfer/sec:     19.43KB
```

For this configuration, the API recived a total of 2186 requests (all without errors), with an average latency of 165.24ms and a total of 48.52 request per second. 

### Test 2

Configuration: 45 seconds, 4 Threads and 50 Connections

```
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   160.12ms   11.84ms 432.06ms   96.83%
    Req/Sec    75.07     17.63   121.00     74.79%
  13463 requests in 45.08s, 5.26MB read
Requests/sec:    298.65
Transfer/sec:    119.58KB
```

For this configuration, the API recived a total of 13463 requests (all without errors), with an average latency of 160.12ms and a total of 298.65 request per second. 

### Test 3

Configuration: 45 seconds, 4 Threads and 100 Connections

```
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   160.17ms   13.67ms 606.68ms   97.32%
    Req/Sec   155.52     24.87   232.00     69.80%
  27824 requests in 45.05s, 10.88MB read
  Socket errors: connect 0, read 0, write 0, timeout 9
Requests/sec:    617.69
Transfer/sec:    247.32KB
```

For this configuration, the API recived a total of 27824 requests with 9 timeout errors (0.032%), an average latency of 160.17ms and a total of 617.69 request per second. 

### Test 4

Configuration: 45 seconds, 4 Threads and 200 Connections

```
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   177.54ms   40.05ms 799.02ms   87.24%
    Req/Sec   281.60     40.64   400.00     68.22%
  50279 requests in 45.07s, 19.66MB read
  Socket errors: connect 0, read 0, write 0, timeout 14
Requests/sec:   1115.46
Transfer/sec:    446.62KB
```

For this configuration, the API recived a total of 50279 requests with 14 timeout errors (0.028%), an average latency of 177.54ms and a total of 1115.46 request per second. 

### Test 5

Configuration: 45 seconds, 4 Threads and 400 Connections

```
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   198.05ms   61.66ms 976.01ms   83.85%
    Req/Sec   506.81     61.36   760.00     71.98%
  90136 requests in 45.09s, 35.24MB read
Requests/sec:   1999.18
Transfer/sec:    800.45KB
```

For this configuration, the API recived a total of 90136 requests (all without errors), with an average latency of 198.05ms and a total of 1999.18 request per second. 

### Test 6

Configuration: 45 seconds, 4 Threads and 800 Connections

```
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   228.29ms  124.76ms   2.00s    92.28%
    Req/Sec   844.40    234.50     1.54k    72.58%
  147445 requests in 45.06s, 57.65MB read
  Socket errors: connect 0, read 0, write 0, timeout 803
Requests/sec:   3272.31
Transfer/sec:      1.28MB
```

For this configuration, the API recived a total of 147445 requests with 803 timeout errors (0.54%), an average latency of 228.29ms and a total of 3272.31 request per second.

### Test 7

Configuration: 45 seconds, 4 Threads and 1600 Connections

```
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   243.74ms   75.39ms   1.67s    62.20%
    Req/Sec     1.00k   314.21     1.82k    67.03%
  164437 requests in 45.07s, 64.30MB read
  Socket errors: connect 583, read 0, write 0, timeout 1483
Requests/sec:   3648.79
Transfer/sec:      1.43MB
```

For this configuration, the API recived a total of 3648.79 requests with 583 connection error and 1483 timeout errors (2066 errors, 1.26%), with an average latency of 243.74ms and a total of 3648.79 request per second.