# hh compile

NFTRepoAddr=`cat ./bin/deployedContracts.json | jq -r '.nftRepo'`
echo -n "export default " > ../web/ui/src/contracts/NFTRepo.ts
cat ./artifacts/contracts/NFTRepo.sol/NFTRepo.json \
    | jq --arg addr "$NFTRepoAddr" ' {address: $addr} + {abi: .abi}' \
    >> ../web/ui/src/contracts/NFTRepo.ts
echo ";" >> ../web/ui/src/contracts/NFTRepo.ts


NFTOwnerAddr=`cat ./bin/deployedContracts.json | jq -r '.nftOwner'`
echo -n "export default " > ../web/ui/src/contracts/NFTOwner.ts
cat ./artifacts/contracts/NFTOwner.sol/NFTOwner.json \
    | jq --arg addr "$NFTOwnerAddr" ' {address: $addr} + {abi: .abi}' \
    >> ../web/ui/src/contracts/NFTOwner.ts
echo ";" >> ../web/ui/src/contracts/NFTOwner.ts

NFTPieceAddr=`cat ./bin/deployedContracts.json | jq -r '.nftPiece'`
echo -n "export default " > ../web/ui/src/contracts/NFTPiece.ts
cat ./artifacts/contracts/NFTPiece.sol/NFTPiece.json \
    | jq --arg addr "$NFTPieceAddr" ' {address: $addr} + {abi: .abi}' \
    >> ../web/ui/src/contracts/NFTPiece.ts
echo ";" >> ../web/ui/src/contracts/NFTPiece.ts
