#!/bin/sh

erlc -D$1 flymake.erl
echo "#!/usr/bin/env escript" > eflymake
cat flymake.beam >> eflymake
chmod +x eflymake
