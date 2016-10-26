FROM debian:experimental
RUN apt-get update

# change installation dialogs policy to noninteractive
# otherwise debconf raises errors: unable to initialize frontend: Dialog
ENV DEBIAN_FRONTEND noninteractive

# install taurus and sardana dependencies
# python-guiqwt is not installed (it depends on spyderlib)
RUN apt-get install -y python ipython python-lxml\
                       python-ply python-tango python-qt4\
                       python-qwt5-qt4 python-numpy

# install spyder dependencies (as from experimental package)
# python-nbconvert is not installed cause is seems to be broken
RUN apt-get install -y libjs-jquery libjs-mathjax pep8 pylint python-bs4\
                       python-jedi python-pep8\
                       python-pickleshare python-psutil python-pyflakes\
                       python-pygments python-qtawesome python-qtconsole\
                       python-rope python-sphinx python-zmq

RUN apt-get install -y python-pip

# install spyder from pip - the experimental package is broken
RUN pip install spyder

# configure virtual monitor env variable (necessary to run graphics in the
# container)
ENV DISPLAY=:1.0

# set USER environment varible which is necessary for the spyder to work
ENV USER root