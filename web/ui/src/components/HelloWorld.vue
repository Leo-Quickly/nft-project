<template>
  <div class="hello">
    <button @click="connect">Connect</button>
    <p>Connected Accounts: {{ connectedAccounts }}</p>
    <p>
      Get owner <button @click="getNFTOwner">getNFTOwner</button>
      {{ nftOwnerAddr }}
    </p>
    <p>Create owner <button @click="createNFTOwner">createNFTOwner</button></p>
    <p>
      Create NFTs <button @click="createNFTPiece">createNFTPiece</button>
      <input type="number" v-model="inputNFTContent" />
    </p>
    <p><button @click="getNFTs">getNFTs</button> {{ nfts }}</p>
  </div>
</template>

<script lang="ts">
import { defineComponent, Ref, ref } from "vue";
import NFTRepo from "@/apis/NFTRepo";

export default defineComponent({
  name: "HelloWorld",
  props: {
    msg: String,
  },
  setup() {
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

    // get contracts
    const nftRepoContract = new NFTRepo(eth);

    const nftOwnerAddr = ref("");
    const getNFTOwner = async () => {
      nftRepoContract
        .getOwner()
        .then((o) => (nftOwnerAddr.value = o))
        .catch((e) => console.error(e));
    };

    const createNFTOwner = async () => {
      nftRepoContract
        .createOwner()
        .then((o) => (nftOwnerAddr.value = o))
        .catch((e) => console.error(e));
    };

    const nfts: Ref<string[]> = ref([]);
    const getNFTs = async () => {
      nftRepoContract
        .getNFTs(0, 10)
        .then((r) => (nfts.value = r))
        .catch((e) => console.error(e));
    };

    const inputNFTContent = ref(0);
    const createNFTPiece = async () => {
      nftRepoContract
        .createNFTPiece(inputNFTContent.value)
        .then(getNFTs)
        .catch((e) => console.error(e));
    };

    return {
      connect,
      connectedAccounts,
      getNFTOwner,
      nftOwnerAddr,
      createNFTOwner,
      nfts,
      getNFTs,
      inputNFTContent,
      createNFTPiece,
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
