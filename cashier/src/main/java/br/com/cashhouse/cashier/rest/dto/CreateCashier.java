package br.com.cashhouse.cashier.rest.dto;

import java.math.BigDecimal;

import javax.validation.constraints.Digits;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateCashier {

	@NotBlank
	String name;

	@NumberFormat(style = Style.CURRENCY)
	@Digits(integer = 10, fraction = 2)
	BigDecimal started;

	@NotNull
	@NumberFormat(style = Style.CURRENCY)
	@Digits(integer = 10, fraction = 2)
	BigDecimal balance;

}
