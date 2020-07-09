# My Task Management
網址：https://joey-task-manage.herokuapp.com/

## 開發環境

- Ruby
- Rails6

##### DB:
- PostgreSQL

##### 套件:
- I18n (ver.1.8.3)
- Rspec (ver.3.4.2)
- Factory Bot (ver.4.8.2)
- Faker (ver.2.13)
- Database Cleaner (ver.1.8.5)
- Figaro (ver.1.0)

## 佈署
詳細請參考→ [
將 Rails 專案佈署至 Heroku 步驟](https://medium.com/@aileen60222/%E5%B0%87-rails-%E5%B0%88%E6%A1%88%E9%83%A8%E7%BD%B2%E5%88%B0-heroku-1d748f4a2625)

## 資料庫設計

<table>    
  <tr>
    <th colspan = "2">User</th>
  </tr>
  <tr>
    <td>name</td>
    <td>string</td>
  </tr>
  <tr>
    <td>email</td>
    <td>string</td>
  </tr>
  <tr>
    <td>admin</td>
    <td>boolean</td>
  </tr>
</table> 
<table>    
  <tr>
    <th colspan = "2">Task</th>
  </tr>
   <tr>
    <td>user_id (fk)</td>
    <td>integer</td>
  </tr>
   <tr>
    <td>title</td>
    <td>string</td>
  </tr>
  <tr>
    <td>content</td>
    <td>text</td>
  </tr>
  <tr>
    <td>start_time</td>
    <td>datetime</td>
  </tr>
  <tr>
    <td>end_time</td>
    <td>datetime</td>
  </tr>
  <tr>
    <td>priority</td>
    <td>integer</td>
  </tr>
  <tr>
    <td>status</td>
    <td>integer</td>
  </tr>
</table> 
<table>    
  <tr>
    <th colspan = "2">Tag</th>
  </tr>
   <tr>
    <td>user_id (fk)</td>
    <td>integer</td>
  </tr>
   <tr>
    <td>name</td>
    <td>string</td>
  </tr>
</table> 
<table>    
  <tr>
    <th colspan = "2">TagTask</th>
  </tr>
   <tr>
    <td>task_id (fk)</td>
    <td>integer</td>
  </tr>
   <tr>
    <td>tag_id (fk)</td>
    <td>integer</td>
  </tr>
</table> 
