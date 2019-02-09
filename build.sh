#!/bin/bash
dotnet --info
echo STARTED git clone
git clone https://github.com/mikedennis/NBitcoin.git
git checkout altcoin-strat-wip

echo STARTED dotnet build
cd NBitcoin
dotnet build

echo STARTED dotnet test

ANYFAILURES=false

echo "Running Altcoin Tests.."; 
COMMAND="dotnet test NBitcoin.Tests.csproj --filter "Altcoins=Altcoins" -p:ParallelizeTestCollections=false --framework netcoreapp2.1"
$COMMAND
EXITCODE=$?
echo exit code for $testProject: $EXITCODE

if [ $EXITCODE -ne 0 ] ; then
    ANYFAILURES=true
fi

cd ..
done

echo FINISHED dotnet test
if [[ $ANYFAILURES == "true" ]] ; then
    exit 1
fi
