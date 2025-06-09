package com.ohot.vo;

import java.util.UUID;

import lombok.Data;

@Data
public class SeqGeneratorVO {
	private UUID uuid;
	private String taskSeNm;
	private String crtrYmd;
	private int reqSn;
}
