#first make

CC = g++
NVCC = nvcc
EXEC = snn

#ADDITIONAL FOLDERS#
COMMON = common/
SERIAL = serial/

#LIBRARIES#
LIB_FLAGS = -lcuda -lcudart
INCLUDE_PATHS = /usr/local/cuda/include
INCUDE_LIB = /usr/local/cuda-7.5/lib64

#COMPILATION FILES#
CPP_FILES = *.cpp
CU_FILES = $(COMMON)*.cu #*.cu

NVCC_FLAGS = --ptxas-options=-v -gencode arch=compute_35,code=sm_35 -rdc=true

all: compile

compile:
	$(CC) -std=c++11 -c $(CPP_FILES) -L $(INCLUDE_LIB) $(LIB_FLAGS) -I$(INCLUDE_PATHS)
	$(NVCC) -std=c++11 $(NVCC_FLAGS) -c $(CU_FILES)
	$(NVCC) -std=c++11 -gencode arch=compute_35,code=sm_35 *.o -o $(EXEC)
	
clean:
	rm *.o
	rm $(EXEC)