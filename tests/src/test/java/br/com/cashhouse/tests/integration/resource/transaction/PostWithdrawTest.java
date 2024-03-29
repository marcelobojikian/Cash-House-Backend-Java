package br.com.cashhouse.tests.integration.resource.transaction;

import static br.com.cashhouse.test.util.integration.SecurityAccess.User.*;
import static org.hamcrest.Matchers.is;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.math.BigDecimal;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.jdbc.Sql.ExecutionPhase;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import br.com.cashhouse.heroku.App;
import br.com.cashhouse.test.util.integration.Oauth2;

@RunWith(SpringRunner.class)
@WebAppConfiguration
@SpringBootTest(classes = App.class)
@Sql(value={ "classpath:schema.sql","classpath:data.sql","classpath:scene.sql"}, executionPhase = ExecutionPhase.AFTER_TEST_METHOD)
public class PostWithdrawTest extends Oauth2 {

	private final static String URL = "/transactions/withdraw";
	private final static String ACTION = "WITHDRAW";

	@Test
	public void save_without_cashier_fail() throws Exception {

		loginWith(JEAN);

		// @formatter:off
		body().add("value", new BigDecimal("11.23"));

		post(URL)
				.andExpect(status().isBadRequest());
        // @formatter:on

	}

	@Test
	public void save_without_value_fail() throws Exception {

		loginWith(JEAN);

		// @formatter:off
		body().add("cashier", 3l);

		post(URL)
				.andExpect(status().isBadRequest());
        // @formatter:on

	}

	@Test
	public void save_without_flatmate_fail() throws Exception {

		loginWith(JEAN);

		// @formatter:off
		body()
			.add("cashier", 3l)
			.add("value", new BigDecimal("11.23"));

		post(URL)
				.andExpect(status().isBadRequest());
        // @formatter:on

	}

	@Test
	public void save_incorrect_value_fail() throws Exception {

		loginWith(JEAN);

		// @formatter:off
		body()
			.add("cashier", 3l)
			.add("value", new BigDecimal("12345678901.23"));

		post(URL)
				.andExpect(status().isBadRequest());
        // @formatter:on

	}

	@Test
	public void save_cashier_NotFound() throws Exception {

		loginWith(JEAN);

		// @formatter:off
		body()
			.add("cashier", 300l)
			.add("flatmate", 9l)
			.add("value", new BigDecimal("1234567890.23"));

		post(URL)
				.andExpect(status().isNotFound());
        // @formatter:on

	}

	@Test
	public void save_flatmate_NotFound() throws Exception {

		loginWith(JEAN);

		// @formatter:off
		body()
			.add("cashier", 3l)
			.add("flatmate", 999l)
			.add("value", new BigDecimal("1234567890.23"));

		post(URL)
				.andExpect(status().isForbidden());
        // @formatter:on

	}

	@Test
	public void save_invalid_value_fail() throws Exception {

		loginWith(JEAN);

		// @formatter:off
		body()
			.add("cashier", 3l)
			.add("flatmate", 9l)
			.add("value", "ABC");

		post(URL)
				.andExpect(status().isBadRequest());
        // @formatter:on

	}

	@Test
	public void save_OK() throws Exception {

		loginWith(JEAN);

		// @formatter:off
		body()
			.add("cashier", 3l)
			.add("flatmate", 8l)
			.add("value", new BigDecimal("1234567890.23"));
		
		post(URL)
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.flatmate.id", is(8)))
				.andExpect(jsonPath("$.cashier.id", is(3)))
				.andExpect(jsonPath("$.status", is("SENDED")))
				.andExpect(jsonPath("$.action", is(ACTION)))
				.andExpect(jsonPath("$.value",is(1234567890.23)));
        // @formatter:on

	}

	@Test
	public void save_flatmate_OK() throws Exception {

		loginWith(JEAN);

		// @formatter:off
		body()
			.add("cashier", 3l)
			.add("flatmate", 9l)
			.add("value", new BigDecimal("1234567890.23"));
		
		post(URL)
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.flatmate.id", is(9)))
				.andExpect(jsonPath("$.cashier.id", is(3)))
				.andExpect(jsonPath("$.status", is("SENDED")))
				.andExpect(jsonPath("$.action", is(ACTION)))
				.andExpect(jsonPath("$.value",is(1234567890.23)));
        // @formatter:on

	}

	@Test
	public void guest_save_OK() throws Exception {

		loginWith(GRETCHEN).dashboard(JEAN);

		// @formatter:off
		body()
			.add("cashier", 3l)
			.add("flatmate", 9l)
			.add("value", new BigDecimal("1234567890.23"));
		
		post(URL)
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.flatmate.id", is(9)))
				.andExpect(jsonPath("$.cashier.id", is(3)))
				.andExpect(jsonPath("$.status", is("SENDED")))
				.andExpect(jsonPath("$.action", is(ACTION)))
				.andExpect(jsonPath("$.value",is(1234567890.23)));
        // @formatter:on

	}

	@Test
	public void guest_save_with_flatmate_Forbidden_fail() throws Exception {

		loginWith(GRETCHEN).dashboard(JEAN);

		// @formatter:off
		body()
			.add("cashier", 3l)
			.add("flatmate", 10l)
			.add("value", new BigDecimal("1234567890.23"));

		post(URL)
				.andExpect(status().isForbidden());
        // @formatter:on

	}

}
