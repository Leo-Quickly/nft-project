import NFTRepoData from "@/contractData/NFTRepoData";
import { Contract, ethers } from "ethers";

class NFTRepo {
  private web3Provider: ethers.providers.Web3Provider;
  private contract: Contract;

  constructor(provider: any) {
    this.web3Provider = new ethers.providers.Web3Provider(provider);
    const signer = this.web3Provider.getSigner();
    this.contract = new ethers.Contract(
      NFTRepoData.address,
      NFTRepoData.abi,
      signer
    );
  }

  async getHello(): Promise<number> {
    return await this.contract.getHello();
  }

  async getOwner() {
    return await this.contract.getOwner();
  }

  async createOwner(): Promise<string> {
    const response = await this.contract.createOwner();
    console.log(`Mining ${response.hash}`);
    return new Promise((resolve, reject) => {
      this.web3Provider.once(response.hash, async (transactionReceipt: any) => {
        console.log(
          `Completed with ${transactionReceipt.confirmations} confirmations. `
        );
        resolve(await this.getOwner());
      });
    });
  }

  async getNFTs(start: number, end: number): Promise<string[]> {
    return await this.contract.getNFTPieces(start, end);
  }

  async createNFTPiece(content: number) {
    const response = await this.contract.createNFTPiece(content);
    console.log(`Mining ${response.hash}`);
    return new Promise((resolve, reject) => {
      this.web3Provider.once(response.hash, async (transactionReceipt: any) => {
        console.log(
          `Completed with ${transactionReceipt.confirmations} confirmations. `
        );
        resolve(null);
      });
    });
  }
}

export default NFTRepo;
