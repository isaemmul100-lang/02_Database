package model.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MenuDTO {
    private int code;
    private String name;
    private int price;
    private int categoryCode;
    private String orderableStatus;
}
