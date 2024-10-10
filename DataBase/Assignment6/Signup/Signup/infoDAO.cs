using MySql.Data.MySqlClient;
using Org.BouncyCastle.Ocsp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Signup
{
    internal class infoDAO


    {

        public static List<info> info_try = new List<info>();

        string connectionString =
        "datasource=localhost;port=3306;username=root;password=root;database=test;";


        public List<info> getAll()
        {
            List<info> returnall = new List<info>();
            MySqlConnection connect = new MySqlConnection(connectionString);
            connect.Open();

            MySqlCommand cmd = new MySqlCommand("SELECT * FROM signup", connect);

            using (MySqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    info ret = new info
                    {
                        ID = reader.GetInt32(0),
                        fName = reader.GetString(1),
                        LName = reader.GetString(2),
                        Sex = reader.GetString(3),
                        Bdate = reader.GetString(4),
                        Email = reader.GetString(5),
                        Occup = reader.GetString(6),
                       

                    };
                    returnall.Add(ret);
                }
            }
            connect.Close();
            return returnall;
        }

        internal int addOneRecord(info a1)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            connect.Open();

            MySqlTransaction transaction = connect.BeginTransaction(); 

            try
            {
              
                MySqlCommand cmdSignup = new MySqlCommand(
                    "INSERT INTO `signup`(`First_Name`, `Last_Name`, `Sex`, `BirthDate`, `Email`, `Occupation`) " +
                    "VALUES (@fname, @lname, @sex, @birthdate, @email, @occupation)",
                    connect, transaction);

                cmdSignup.Parameters.AddWithValue("@fname", a1.fName);
                cmdSignup.Parameters.AddWithValue("@lname", a1.LName);
                cmdSignup.Parameters.AddWithValue("@sex", a1.Sex);
                cmdSignup.Parameters.AddWithValue("@birthdate", a1.Bdate);
                cmdSignup.Parameters.AddWithValue("@email", a1.Email);
                cmdSignup.Parameters.AddWithValue("@occupation", a1.Occup);

                int signupRows = cmdSignup.ExecuteNonQuery();

                long signupID = cmdSignup.LastInsertedId;

              
                MySqlCommand cmdLogin = new MySqlCommand(
                    "INSERT INTO `login`(`Signup_ID`, `Username`, `Password`) " +
                    "VALUES (@signupID, @username, @password)", connect, transaction);

                cmdLogin.Parameters.AddWithValue("@signupID", signupID); 
                cmdLogin.Parameters.AddWithValue("@username", a1.Signup_User);
                cmdLogin.Parameters.AddWithValue("@password", a1.Signup_Pass);

                int loginRows = cmdLogin.ExecuteNonQuery();

         
                transaction.Commit();

            
                return signupRows + loginRows;
            }
            catch (Exception ex)
            {
           
                transaction.Rollback();
                MessageBox.Show("Error: " + ex.Message);
                return 0;
            }
            finally
            {
                connect.Close();
            }
        }


        internal int updateOneRecord(info a1)
        {

            MySqlConnection connect = new MySqlConnection(connectionString);
            connect.Open();
            MySqlCommand cmd = new MySqlCommand("UPDATE signup SET First_Name = @fname, Last_Name = @lname, Sex = @sex, BirthDate = @birthdate, Email = @email, Occupation = @Occupation WHERE ID = @ID", connect);
            cmd.Parameters.AddWithValue("@ID", a1.ID);
            cmd.Parameters.AddWithValue("@fname", a1.fName);
            cmd.Parameters.AddWithValue("@lname", a1.LName);
            cmd.Parameters.AddWithValue("@sex", a1.Sex);
            cmd.Parameters.AddWithValue("@birthdate", a1.Bdate);
            cmd.Parameters.AddWithValue("@email", a1.Email);
            cmd.Parameters.AddWithValue("@Occupation", a1.Occup);
            int newRows = cmd.ExecuteNonQuery();
            connect.Close();
            return newRows;

        }

        internal int deleteOneRecord(int signupId)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            connect.Open();

            MySqlTransaction transaction = connect.BeginTransaction(); 

            try
            {
              
                MySqlCommand cmdLogin = new MySqlCommand("DELETE FROM login WHERE Signup_ID = @signupId", connect, transaction);
                cmdLogin.Parameters.AddWithValue("@signupId", signupId);
                int loginRows = cmdLogin.ExecuteNonQuery();

               
                MySqlCommand cmdSignup = new MySqlCommand("DELETE FROM signup WHERE ID = @signupId", connect, transaction);
                cmdSignup.Parameters.AddWithValue("@signupId", signupId);
                int signupRows = cmdSignup.ExecuteNonQuery();

                transaction.Commit();

                return loginRows + signupRows; 
            }
            catch (Exception ex)
            {
               
                transaction.Rollback();
                MessageBox.Show("Error: " + ex.Message);
                return 0;
            }
            finally
            {
                connect.Close();
            }
        }



        public bool IsUsernameUnique(string username)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            connect.Open();

            MySqlCommand cmd = new MySqlCommand("SELECT COUNT(*) FROM login WHERE Username = @username", connect);
            cmd.Parameters.AddWithValue("@username", username);

            int count = Convert.ToInt32(cmd.ExecuteScalar());
            connect.Close();

            return count == 0; // Return true if no matching usernames are found
        }

        public bool IsPasswordUnique(string password)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            connect.Open();

            MySqlCommand cmd = new MySqlCommand("SELECT COUNT(*) FROM login WHERE Password = @password", connect);
            cmd.Parameters.AddWithValue("@password", password);

            int count = Convert.ToInt32(cmd.ExecuteScalar());
            connect.Close();

            return count == 0; // Return true if no matching passwords are found
        }


        public bool ValidateLogin(string username, string password)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            connect.Open();

            MySqlCommand cmd = new MySqlCommand("SELECT COUNT(*) FROM login WHERE Username = @username AND Password = @password", connect);
            cmd.Parameters.AddWithValue("@username", username);
            cmd.Parameters.AddWithValue("@password", password);

            int count = Convert.ToInt32(cmd.ExecuteScalar());

            connect.Close();

            return count > 0; // Return true if the username and password are correct
        }

        public List<info> getUserInfoById(int signupId)
        {
            List<info> returnall = new List<info>();
            MySqlConnection connect = new MySqlConnection(connectionString);
            connect.Open();

            
            MySqlCommand cmd = new MySqlCommand("SELECT ID, First_Name, Last_Name, Sex, Birthdate, Email, Occupation FROM signup WHERE ID = @signupId", connect);
            cmd.Parameters.AddWithValue("@signupId", signupId);

            using (MySqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    info ret = new info
                    {
                        ID = reader.GetInt32(0),
                        fName = reader.GetString(1),
                        LName = reader.GetString(2),
                        Sex = reader.GetString(3),
                        Bdate = reader.GetString(4),
                        Email = reader.GetString(5),
                        Occup = reader.GetString(6)
                    };
                    returnall.Add(ret);
                }
            }
            connect.Close();
            return returnall;
        }

        public int GetUserId(string username, string password)
        {
            MySqlConnection connect = new MySqlConnection(connectionString);
            connect.Open();

            MySqlCommand cmd = new MySqlCommand("SELECT Signup_ID FROM login WHERE Username = @username AND Password = @password", connect);
            cmd.Parameters.AddWithValue("@username", username);
            cmd.Parameters.AddWithValue("@password", password);

            object result = cmd.ExecuteScalar();
            connect.Close();

            if (result != null)
            {
                return Convert.ToInt32(result); // Return Signup_ID if credentials are valid
            }
            else
            {
                return -1; // Invalid credentials
            }
        }


        // Create a connectionString specifying datasource, port, username, password and database

        // Function to add new record
        /*
         internal int addOneRecord(info a1)
         {
             // Create MySqlConnection object and open a connection using connectionstring


             // Create MySqlCommand object referring with the table with proper column names and insert parameter values



             // Create a integer variable to obtain value which indicates the number of rows affected by the SQL command (ExecuteNonQuery)


             //Close Connection


             // return new Rows
         }

         // Function to retrieve information
         public List<info> getAll()
         {
             // Create a list of object of class info


             // Create MySqlConnection object and open connection



             // Create MySqlCommand object which read all the records in database


             // Create MySqlDataReader object and read all the data gained from  MySqlCommand object. Pass the data to relevant info class parameter
             using (//Create MySqlDataReader object and read all the data gained from  MySqlCommand object)
             {
                 while (//Read Data)
                 {
                     // Create a info class object and pass info to relevant variable
                     //eg for string reader.GetString and for integer reader.GetInt32


                     //Add all information to info class object
                 }
             }
             // Close connection

             // Return all records

         }

         // Function to update one record
         internal int updateOneRecord(info a1)
         {
             // Create MySqlConnection object and open a connection using connectionstring


             // Create MySqlCommand object and write SQL code to update table record based on ID


             //Use MySqlCommand object to add value to corresponding parameter 

             // Create a integer variable to obtain value which indicates the number of rows affected by the SQL command (ExecuteNonQuery)


             //Close Connection


             // return new Rows


         }

         // Function to delete one record
         internal int deleteOneRecord(int id_row)
         {
             // Create MySqlConnection object and open a connection using connectionstring


             // Create MySqlCommand object and write SQL code to delete table record based on ID


             //Use MySqlCommand object to add value to corresponding id 

             // Create a integer variable to obtain value which indicates the number of rows affected by the SQL command (ExecuteNonQuery)


             //Close Connection


             // return new Rows
         }
        */
    }
}