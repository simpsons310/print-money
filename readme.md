# In tiền tool :moneybag:

Dành cho những người nghèo không có tiền có thể in tiền một cách nhanh chóng :smiley:

## Cách dùng

- Mở command prompt trong folder code, chạy command `print.bat`, với các tham số sau

```bat
print.bat [total] [options...]
```

| Long Arg          | Short Arg | Default   | Mô tả                                                                         |
| ----------------- | --------- | --------- | ----------------------------------------------------------------------------- |
| `--denomination`  | `-d`      | `500`     | Mệnh giá tiền, hiện hỗ trợ các mệnh giá `500`, `200`, `100`, `50`, `20`, `10` |
| `--currency`      | `-c`      | `VND`     | Loại tiền tệ, hiện hỗ trợ `VND`                                               |
| `--label`         | `-l`      |           | Tên folder output, mặc định là tổng số tiền                                   |

- Ví dụ

```bat
# In tỷ VNĐ bằng tờ 500k
print.bat 1000000 --label "1 ty"
print.bat 1000000 --label "1 ty" --currency "VND" --denomination 500
```

- Kết quả

![Result](./asset/images/result.png)
