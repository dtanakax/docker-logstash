![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

docker-logstash
=====================

Base Docker Image
---------------------

[dtanakax/debianjp:wheezy](https://registry.hub.docker.com/u/dtanakax/debianjp/)

説明
---------------------

Logstash Dockerコンテナイメージです。


使用方法
---------------------

最初に[elasticsearchコンテナ](https://bitbucket.org/dtanakax/docker-elasticsearch)を起動

    $ docker run --name es -d -p 9200:9200 -it dtanakax/elasticsearch

起動したelasticsearchコンテナをリンクしてKibanaコンテナを起動
(注: aliasをelasticsearchと指定して下さい。)  

    $ docker run -p 5043:5043 -p 5000:5000 --link es:elasticsearch -it dtanakax/kibana

logspoutでDockerコンテナのログの集約・ルーティング
---------------------

1. elkstackを起動

    ここでは[Docker Compose設定サンプル](https://bitbucket.org/dtanakax/compose-examples)を使用します。

        $ cd compose-examples/elkstack
        $ docker-compose up

2. logstashコンテナのIPアドレスを取得します。

        $ docker inspect --format '{{ .NetworkSettings.IPAddress }}' elkstack_logstash_1
        172.17.X.XX

3. 取得したIPアドレスを指定しlogspoutを起動

        $ docker run -d --name log -v=/var/run/docker.sock:/tmp/docker.sock gliderlabs/logspout syslog://<ipaddr>:5000

    以上で、Kibanaをブラウザから起動すると全コンテナのシステムログを可視化されます。

利用可能なボリューム
---------------------

以下のボリュームが利用可能

    /opt/conf       # 設定ファイル
    /opt/certs      # 秘密鍵ファイル

License
---------------------

The MIT License
Copyright (c) 2015 Daisuke Tanaka

以下に定める条件に従い、本ソフトウェアおよび関連文書のファイル（以下「ソフトウェア」）の複製を取得するすべての人に対し、ソフトウェアを無制限に扱うことを無償で許可します。これには、ソフトウェアの複製を使用、複写、変更、結合、掲載、頒布、サブライセンス、および/または販売する権利、およびソフトウェアを提供する相手に同じことを許可する権利も無制限に含まれます。

上記の著作権表示および本許諾表示を、ソフトウェアのすべての複製または重要な部分に記載するものとします。

ソフトウェアは「現状のまま」で、明示であるか暗黙であるかを問わず、何らの保証もなく提供されます。ここでいう保証とは、商品性、特定の目的への適合性、および権利非侵害についての保証も含みますが、それに限定されるものではありません。 作者または著作権者は、契約行為、不法行為、またはそれ以外であろうと、ソフトウェアに起因または関連し、あるいはソフトウェアの使用またはその他の扱いによって生じる一切の請求、損害、その他の義務について何らの責任も負わないものとします。

The MIT License
Copyright (c) 2015 Daisuke Tanaka

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.