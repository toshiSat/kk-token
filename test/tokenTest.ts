import { ethers, getNamedAccounts } from 'hardhat'
import { expect } from 'chai'
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers'
import { BigNumber } from 'ethers'
import { Token } from '../typechain-types'

const precision = 18

describe('Token', function () {
  let accounts: SignerWithAddress[]
  let tokenContract: Token

  beforeEach(async () => {
    const tokenDeployment = await ethers.getContractFactory('Token')
    const totalSupply = BigNumber.from(21000000)
    tokenContract = await tokenDeployment.deploy(totalSupply)
    expect(await tokenContract.totalSupply()).to.equal(totalSupply)
  })

  it('Should be able to burn', async () => {
   
  })
})
