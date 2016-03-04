PART I实际上是在对协同过滤算法做剖析，在工程代码里面没有被体现出来.
按照PART II就可以搭建下文的环境.

以下步骤均在Linux中执行

1. 服务器没有安装OpenSSL，因此自己编译的Python默认不支持https，造成一些软件包无法安装，因此首先安装OpenSSL，再重新编译Python2.7.6

2. 在源码目录建立datasets目录，将数据ml-latest.zip解压到datasets目录

3. 查看端口5432是否被占用(netstat -apn | grep 5432, 这是PostgreSQL的常用端口)

4. chmod a+x start_server.sh，并执行(脚本内容修改为Local模式; 若为集群模式，需要将数据拷贝到集群其他机器，因为文件是从本地文件系统中读取的)

5. 根据错误情况，安装缺失的包. 包括CherryPy-5.0.1, Flask-0.10.1, numpy-1.9.2, Paste-2.0.2, setuptools-19.3等

6. 为用户668推荐10部电影 http://BigData1637:5432/668/ratings/top/10
[["Connections (1978)", 4.080624295642869, 41], 
["\"Shawshank Redemption", 3.83204674811725, 77887], 
["Eu N\u00e3o Quero Voltar Sozinho (I Don't Want to Go Back Alone) (2010)", 3.8072335714057055, 31], 
["Schindler's List (1993)", 3.7855396809252264, 59857], 
["Dylan Moran Live: What It Is (2009)", 3.772563367814993, 51], 
["\"Dylan Moran: Yeah", 3.7342040917738135, 52], 
["TT3D: Closer to the Edge (2011)", 3.7133137254510813, 40], 
["The Adventures of Sherlock Holmes and Dr. Watson: The Hound of the Baskervilles (1981)", 3.6955427569470594, 32], 
["The Lost Room (2006)", 3.689645543261984, 73], 
["\"What's in a Name (Pr\u00e9nom", 3.684771476085861, 44]]
其中第一项为电影名称，第二项为模型预测的该用户会对该电影打几分(用户还没有看过这部电影)，第三项为目前已经为该电影打过分的总人数

7. 预测一下用户668会对ID为500的电影打几分 http://BigData1637:5432/668/ratings/500
[["Mrs. Doubtfire (1993)", 3.048332015038002, 35753]]

8. 预测一下用户668会对ID为86237的电影打几分 http://BigData1637:5432/668/ratings/86237
[["Connections (1978)", 4.080624295642869, 41]]
看看，跟第6步排名第一的结果一样！

9. 预测一下用户668会对ID为318的电影打几分 http://BigData1637:5432/668/ratings/318
[["\"Shawshank Redemption", 3.83204674811725, 77887]]
看看，跟第6步排名第二的结果一样！

BUG: 
movies.csv中，电影名称为"Shawshank Redemption, The (1994)"，而非"Shawshank Redemption". 分割电影名称时引入的问题

