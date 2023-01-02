<template>
  <div class="hello">
    <button @click="connect">Connect</button>
    <p>Connected Accounts: {{ connectedAccounts }}</p>
    <p>Request Repo <button @click="requestNFTRepo">Repo</button></p>
    <p>Response from NFTRepo {{ nftRepo }}</p>
    <p>Response from NFTOwner {{ nftOwner }}</p>
    <p>Response from NFTPiece {{ nftPiece }}</p>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
import { ethers } from "ethers";
import NFTOwner from "@/contracts/NFTOwner";
import NFTRepo from "@/contracts/NFTRepo";
import NFTPiece from "@/contracts/NFTPiece";

function listenForTransactionMine(transactionResponse: any, provider: any) {
  console.log(`Mining ${transactionResponse.hash}`);
  return new Promise((resolve, reject) => {
    provider.once(transactionResponse.hash, (transactionReceipt: any) => {
      console.log(
        `Completed with ${transactionReceipt.confirmations} confirmations. `
      );
      resolve(transactionReceipt);
    });
  });
}

export default defineComponent({
  name: "HelloWorld",
  props: {
    msg: String,
  },
  setup() {
    const nftRepoValue = ref(1);
    const nftOwnerValue = ref(2);
    const nftPieceValue = ref(3);

    const connectedAccounts = ref("");

    // metamask
    // @ts-expect-error Window.ethereum not typed
    const eth = window.ethereum;
    if (!eth) {
      console.log("Please install MetaMask");
    }

    const connect = async () => {
      console.log("Connecting");
      try {
        await eth.request({ method: "eth_requestAccounts" });
        console.log("Connected");
        const accounts: string[] = await eth.request({
          method: "eth_accounts",
        });
        console.log(accounts);
        connectedAccounts.value = accounts.join(",");
      } catch (error) {
        console.log(error);
      }
    };

    const requestNFTRepo = async () => {
      const provider = new ethers.providers.Web3Provider(eth);
      const signer = provider.getSigner();
      const nftRepo = new ethers.Contract(NFTRepo.address, NFTRepo.abi, signer);
      const code = await provider.getCode(NFTRepo.address);
      console.log(code);

      try {
        const response = await nftRepo.getHello();
        nftRepoValue.value = response;
        console.log(`response: ${response}`);
      } catch (error) {
        console.log(error);
      }
    };

    return {
      nftRepo: nftRepoValue,
      nftOwner: nftOwnerValue,
      nftPiece: nftPieceValue,
      connect,
      connectedAccounts,
      requestNFTRepo,
    };
  },
});
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
