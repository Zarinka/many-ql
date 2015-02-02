#!/bin/bash

#Copyright (c) 2013, Carlos Ulderico Cirello Filho
#All rights reserved.
#
#Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#
#Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
#Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
#Neither the name of the Carlos Ulderico Cirello Filho nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

sha=0
previous_sha=0
export DIR=$1;
export EXTERNAL_CALL=$2
update_sha(){
	command="ls -lR "$DIR" | sha1sum"
	sha=`bash -c "$command"`
}
build () {
	bash -c "$EXTERNAL_CALL"
	echo -e "\n--> Monitor: Monitoring filesystem... (Press enter to force a build/update)"
}
changed () {
	echo "--> Monitor: Files changed, Building..."
	build
	previous_sha=$sha
}
compare () {
	update_sha
	if [[ $sha != $previous_sha ]] ; then changed; fi
}
run () {
	while true; do
		compare
		read -s -t 1 && (
			echo "--> Monitor: Forced Update..."
			build
		)
	done
}
echo "--> Monitor: Init..."
echo "--> Monitor: Monitoring filesystem... (Press enter to force a build/update)"
run
