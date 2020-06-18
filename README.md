# Rails-Practice
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
    <td>task_id (fk)</td>
    <td>integer</td>
  </tr>
   <tr>
    <td>name</td>
    <td>string</td>
  </tr>
</table> 
