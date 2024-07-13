function install_dependency() {
	sudo apt install clang++ cmake ocl-icd-opencl-dev ocl-icd-dev opencl-headers clinfo libraspberrypi-dev
}

function check_dependency() {

}

function build() {
	mkdir -p VC4C/build VC4CL/build VC4CLStdLib/build

	pushd VC4CLStdLib/build
	cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo
	make
	sudo make install
	sudo ldconfig
	popd

	pushd VC4C/build
	cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_TESTING=OFF
	make
	sudo make install
	sudo ldconfig
	popd

	pushd VC4CL/build
	cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_TESTING=OFF -DBUILD_ICD=ON
	make
	sudo make install
	popd
}

function test() {
	mkdir -p great-opencl-examples/build
}

install_dependency
check_dependency
build
test
