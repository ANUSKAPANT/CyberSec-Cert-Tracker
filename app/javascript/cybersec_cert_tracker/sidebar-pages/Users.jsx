import React, { useEffect, useState, CSSProperties } from "react";
import "../table.css";
import DashboardTable from "../DashboardTable";
import { Button } from "reactstrap";
import Modal from "@mui/material/Modal";
import Box from "@mui/material/Box";
import { FileUploader } from "react-drag-drop-files";
import axios from "axios";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import ClipLoader from "react-spinners/ClipLoader";
import "../Dashboard.css";
import Jsona from "jsona";

const override = {
  display: "block",
  margin: "0 auto",
  borderColor: "red",
};

const style = {
  position: "absolute",
  top: "50%",
  left: "50%",
  transform: "translate(-50%, -50%)",
  width: 400,
  bgcolor: "background.paper",
  border: "2px solid #000",
  boxShadow: 24,
  p: 4,
};

const dataFormatter = new Jsona();

function Users({ userData }) {
  const [loading, setLoading] = useState(true);
  const [users, setUsers] = useState([]);
  const [open, setOpen] = React.useState(false);

  const fetchRecords = async () => {
    axios
      .get(`/users.json`, {
        headers: { Authorization: `Bearer ${userData.token}` },
      })
      .then((response) => {
        // const data = dataFormatter.deserialize(response.data);

        console.log(response);

        // const userData = data.map((user) => {
        //   return {
        //     id: user.id,

        //     full_name: user.full_comma_separated_name,

        //     first_name: user.first_name,

        //     last_name: user.last_name,

        //     email_id: user.email_id,

        //     canvas_id: user.canvas_id,

        //     company: user.company,

        //     courses: user.user_courses.map((sc) => {
        //       return {
        //         id: sc.course.id,
        //         name: sc.course.name,
        //       };
        //     }),
        //   };
        // });

        // setLoading(false);
        // setUsers(userData);

        // console.log(userData);
      })

      .catch((error) => {
        console.log(error);
        toast.error("Error in fetching records", {
          position: "bottom-center",
          autoClose: 3000,
          hideProgressBar: false,
          closeOnClick: true,
        });
      });
  };

  useEffect(() => {
    fetchRecords();
  }, []);

  const deleteRecords = async (idx) => {
    axios
      .delete(`/users/${idx}`, {
        headers: { Authorization: `Bearer ${userData.token}` },
      })
      .then((res) => {
        toast.success("Successfully Deleted", {
          position: "bottom-center",
          autoClose: 3000,
          hideProgressBar: false,
          closeOnClick: true,
        });
      })
      .catch((err) => {
        toast.error("Error in deletingrecords", {
          position: "bottom-center",
          autoClose: 3000,
          hideProgressBar: false,
          closeOnClick: true,
        });
      });
  };

  const deleteItem = (idx) => {
    deleteRecords(idx);
    setUsers((prev) => {
      const tempArray = prev.slice();
      return tempArray.filter((item) => item.id !== idx);
    });
  };

  return (
    <>
      <ToastContainer />
      <Button
        color="success"
        className="csv-button"
        onClick={() => setOpen(true)}
        id="uploadCSVButton"
      >
        + Add Users
      </Button>
      <Modal
        open={open}
        onClose={() => setOpen(false)}
        aria-labelledby="modal-modal-title"
        aria-describedby="modal-modal-description"
      >
        <Box sx={style}></Box>
      </Modal>
      {loading == true ? (
        <div className="spinner-container">
          <div className="spinner">
            <ClipLoader color="blue" />
          </div>
          <div>Fetching the data...</div>
        </div>
      ) : users.length === 0 ? (
        <div className="">No Table Records to Show</div>
      ) : (
        <DashboardTable data={users} type="User" deleteItem={deleteItem} />
      )}
    </>
  );
}

export default Users;