<?php

namespace SistemaBancario;

class ContaPoupanca extends Conta
{
    public function __construct(int $numero, Titular $titular)
    {
        parent::__construct($numero, $titular);
    }

    public function depositar(float $valor): void
    {
        if ($valor <= 0) {
            throw new InvalidArgumentException("O valor do depósito deve ser positivo.");
        }

        $this->saldo += $valor;
    }

    public function sacar(float $valor): void
    {
        $valorComTaxa = $valor * 1.005; // Taxa de saque de 0.5%
        if ($valor <= 0) {
            throw new InvalidArgumentException("O valor do saque deve ser positivo.");
        }
        if ($valorComTaxa > $this->saldo) {
            throw new RuntimeException("Saldo insuficiente para o saque.");
        }

        $this->saldo -= $valorComTaxa;
    }

    public function __toString(): string
    {
        return "Conta Poupança - " . parent::__toString();
    }
}