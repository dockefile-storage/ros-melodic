说明
======

创建镜像
----------

.. code-block:: sh

    $ sudo docker build -t  ros-melodic:v1.0.0 .

创建容器
----------

.. code-block:: sh

	#$ sudo docker run -d --restart=always --name=ros-melodic -p 1022:22 --dns=114.114.114.114 --dns=180.76.76.76 ros-melodic:[version]
	#$ sudo docker run -d --restart=always --privileged  --name=ros-melodic -p 1022:22 --dns=114.114.114.114 --dns=180.76.76.76 ros-melodic:[version]

	#$ sudo docker run -d --restart=always --name=ros-melodic --dns=114.114.114.114 --dns=180.76.76.76 ros-melodic:v1.0.0
	#$ sudo docker run -d --rm  --name=ros-melodic --dns=114.114.114.114 --dns=180.76.76.76 ros-melodic:v1.0.0
