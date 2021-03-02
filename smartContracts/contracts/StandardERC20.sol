// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/24a0bc23cfe3fbc76f8f2510b78af1e948ae6651/contracts/token/ERC20/IERC20.sol";

contract StandardERC20 is IERC20 {
    // state variables
    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor (string memory _name_, string memory _symbol_, uint256 _totalSupply_) {
        _name = _name_;
        _symbol = _symbol_;
        _decimals = 18;
        _totalSupply = _totalSupply_;
        _balances[msg.sender] = _balances[msg.sender] + _totalSupply_;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view  returns (string memory){
        return _symbol;
    }

    function decimals() public view returns(uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, recipient,amount );
        return true;
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function allowance(address owner, address spender) public override view returns(uint256) {
        return _allowances[owner][spender];
    } 

    function transferFrom(address sender, address recipient, uint256 amount) public override returns(bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender] - amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(recipient != address(0),"ERC20: transfer from zero transfer");
        require(sender != address(0),"ERC20: transfer from zero transfer");

        require(_balances[sender] >= amount, "ERC20: sender does not have enough amount");

        _balances[sender] = _balances[sender] - amount;
        _balances[recipient] = _balances[recipient] + amount;
        emit Transfer(sender, recipient, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
      require(spender != address(0),"ERC20: transfer from zero transfer");
      require(owner != address(0),"ERC20: transfer from zero transfer");

      require(_balances[owner] >= amount, "ERC20: owner does not have enough amount");
      _allowances[owner][spender] = amount;
      emit Approval(owner, spender, amount);
    }


    function mint(address _toAccount, uint256 _amount) public {
      require(_toAccount != address(0), "ERC20: mint to the zero address");

      require(_totalSupply + _amount >= _totalSupply,"overflow");

      require(_balances[_toAccount] + _amount >= _balances[_toAccount],"overflow");

      _totalSupply += _amount;
      _balances[_toAccount] += _amount;
      emit Transfer(address(0), _toAccount, _amount);
    }


    function burn(address _fromAccount, uint256 _amount) public {
         require(_fromAccount != address(0), "ERC20: mint to the zero address");

         require(_balances[_fromAccount] - _amount <= _balances[_fromAccount],"underflow");

         require(_totalSupply - _amount <= _totalSupply,"underflow");

         _totalSupply -= _amount;
         _balances[_fromAccount] -= _amount;
         emit Transfer(_fromAccount, address(0), _amount);
    }

    function increaseAllowance(address spender, uint256 addedValue) public returns(bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender] + addedValue);
        return true;
    }

        function decreaseAllowance(address spender, uint256 addedValue) public returns(bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender] - addedValue);
        return true;
    }




}

