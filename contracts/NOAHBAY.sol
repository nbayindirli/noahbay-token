pragma solidity ^0.8.0;

import '@openzeppelin/contracts/utils/Context.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract NOAHBAY is ERC20 {

    string private _name = 'NOAHBAY';
    string private _symbol = 'NOAHBAY';

    uint private _taxMinimum = 500;
    string private _taxMinimumErrorMessage = 'ERROR: Minimum tax threshold not satisfied. Transaction denied.';

    address private _owner = 0x2d54EC30Be0D2583b0d781e10B31905c3c54616d;

    constructor() ERC20 (_name, _symbol) {
        _mint(_msgSender(), 10 ** 12 * 10 ** 18);
    }

    function _transfer(address _sender, address _recipient, uint256 _amount) internal override {
        /* Assess Burn */
        uint _burnAmount = (_amount * 150) / 10000;
        uint _amountBurned = _amount - _burnAmount;

        /* Assess Tax */
        uint _taxAmount = (_amountBurned * 17) / 10000;
        uint _amountTaxedAndBurned = _amountBurned - _taxAmount;

        /* Enforce minimum tax threshold */
        require(_taxAmount >= _taxMinimum, _taxMinimumErrorMessage);

        /* Burn */
        super._burn(_sender, _burnAmount);

        /* Distribute */
        super._transfer(_sender, _owner, _taxAmount);
        super._transfer(_sender, _recipient, _amountTaxedAndBurned);
    }
}
