# hh compile

NFTRepoAddr=`cat ./bin/deployedContracts.json | jq -r '.nftRepo'`
echo -n "export default " > ../web/ui/src/contractData/NFTRepoData.ts
cat ./artifacts/contracts/NFTRepo.sol/NFTRepo.json \
    | jq --arg addr "$NFTRepoAddr" ' {address: $addr} + {abi: .abi}' \
    >> ../web/ui/src/contractData/NFTRepoData.ts
echo ";" >> ../web/ui/src/contractData/NFTRepoData.ts


NFTOwnerAddr=`cat ./bin/deployedContracts.json | jq -r '.nftOwner'`
echo -n "export default " > ../web/ui/src/contractData/NFTOwnerData.ts
cat ./artifacts/contracts/NFTOwner.sol/NFTOwner.json \
    | jq --arg addr "$NFTOwnerAddr" ' {address: $addr} + {abi: .abi}' \
    >> ../web/ui/src/contractData/NFTOwnerData.ts
echo ";" >> ../web/ui/src/contractData/NFTOwnerData.ts

NFTPieceAddr=`cat ./bin/deployedContracts.json | jq -r '.nftPiece'`
echo -n "export default " > ../web/ui/src/contractData/NFTPieceData.ts
cat ./artifacts/contracts/NFTPiece.sol/NFTPiece.json \
    | jq --arg addr "$NFTPieceAddr" ' {address: $addr} + {abi: .abi}' \
    >> ../web/ui/src/contractData/NFTPieceData.ts
echo ";" >> ../web/ui/src/contractData/NFTPieceData.ts
