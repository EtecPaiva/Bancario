<?php

namespace SistemaBancario;

class ContaCorrente extends Conta
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

        $this->saldo += $valor * 0.99; // Taxa de depósito de 1%
    }

    public function sacar(float $valor): void
    {
        $valorComTaxa = $valor * 1.01; // Taxa de saque de 1%
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
        return "Conta Corrente - " . parent::__toString();
    }
}