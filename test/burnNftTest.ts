import { ethers, getNamedAccounts } from 'hardhat'
import { expect } from 'chai'
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers'
import { BigNumber } from 'ethers'
import { BurnNft, Token } from '../typechain-types'

const precision = 18

describe('BurnNft', function () {
  let accounts: SignerWithAddress[]
  let tokenContract: Token
  let burnContract: BurnNft

  beforeEach(async () => {
    // Launch Token contract
    const tokenDeployment = await ethers.getContractFactory('Token')
    const totalSupply = BigNumber.from(21000000)
    tokenContract = await tokenDeployment.deploy(totalSupply)
    await tokenContract.deployed()

    // Launch BurnNFt contract
    const burnDeployment = await ethers.getContractFactory('BurnNft')
    burnContract = await burnDeployment.deploy(tokenContract.address)
    await burnContract.deployed()
    expect(await burnContract.KEEP_KEY_TOKEN()).to.equal(tokenContract.address)
  })

  it('Should mint nft', async () => {})
})
