package br.com.cashhouse.user.rest.dto;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Propertie {

	@NotEmpty
	String value;

}