package br.com.cashhouse.cashier.rest.dto;

import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateCashier {

	@NotBlank
	String name;

}
