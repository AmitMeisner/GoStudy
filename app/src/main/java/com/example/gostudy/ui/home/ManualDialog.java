package com.example.gostudy.ui.home;

import android.os.Bundle;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.Button;

import androidx.annotation.NonNull;
import androidx.fragment.app.DialogFragment;

import com.example.gostudy.R;

public class ManualDialog extends DialogFragment {
    Button btn_dismiss;
    Button btn_ok;
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.manual_dialog, container, false);

        btn_dismiss = view.findViewById(R.id.manualButton_dismiss);
        btn_ok = view.findViewById(R.id.manualButton_ok);

        //dismiss the manual dialog
        btn_dismiss.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getDialog().dismiss();

            }
        });
        //send data of date and duration to server
        btn_ok.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getDialog().dismiss();

            }
        });

        return view;
    }
}
