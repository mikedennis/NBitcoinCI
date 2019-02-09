#!/bin/bash
dotnet --info
echo STARTED git clone
git clone --single-branch --branch altcoin-strat-wip https://github.com/mikedennis/NBitcoin.git

echo STARTED dotnet build --framework netcoreapp2.1
cd NBitcoin
dotnet build

echo STARTED dotnet test

ANYFAILURES=false

echo "Running Altcoin Tests.."; 
cd NBitcoin.Tests
COMMAND="dotnet test NBitcoin.Tests.csproj --filter Altcoins=Altcoins -p:ParallelizeTestCollections=false --framework netcoreapp2.1"
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
