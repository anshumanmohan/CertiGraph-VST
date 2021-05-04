
# NOTE:

# Users must first build this dockerfile with some tag:
#   docker build -t imagename .
# The tag "imagename" is, of course, just a variable.
# Please note the period in the build step.

# All the commands below will execute when "docker build" is run.
# The last step is very slow; over 3 hours on our virtual machine (4 CPUs, 8GB memory, and 4GB swap) 
# Users may want to go to Docker Preferences > Advanced
#   and dedicate a large amount of RAM and CPU storage to the Docker machine to speed up the build. 
# This may also prevent processes from being killed by the Docker daemon for overusing resources.

# After the build has completed, run the machine:
#   docker run -it imagename
# and explore our codebase under CertiGraph-VST/CertiGraph/


FROM coqorg/coq:8.13.2
# We start with Coq from the official source

RUN opam install --jobs=2 -y coq-flocq
# We will also need FLOCQ (floats for Coq)

RUN git clone https://github.com/anshumanmohan/CertiGraph-VST
# We download our project from Github

RUN sudo apt-get update && sudo apt-get install -y emacs
# Next, to help readers explore our code, we add a text editor.

RUN git clone https://github.com/ProofGeneral/PG ~/.emacs.d/lisp/PG && cd ~/.emacs.d/lisp/PG && make && echo "(load \"~/.emacs.d/lisp/PG/generic/proof-site\")" >> ~/.emacs.d/init.el && cd -
# ProofGeneral gives additional syntax highlighting, a REPL, etc

RUN cd CertiGraph-VST/CertiGraph/ && make vstandcav7
# We build our project


# If this is all too cumbersome and slow, we encourage users to use our
#   fully compiled build available via: docker pull anshumanmohan/certidpk_built
# That repository is simply this very Dockerfile, but in that case we
#   (1) built the image
#   (2) committed the changes to the image
#   (3) pushed that image to the repository
# This allows users to avoid compiling the code themselves.
