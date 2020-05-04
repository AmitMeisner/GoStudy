package com.example.gostudy;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

public class TipsFragment extends Fragment {

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState){
        final View root = inflater.inflate(R.layout.fragment_tips, container, false);

        Button submitTipBtn = (Button) root.findViewById(R.id.submitTipBtn);

        submitTipBtn.setOnClickListener(new View.OnClickListener() {
            @SuppressLint("SetTextI18n")
            @Override
            public void onClick(View v) {
                EditText user_tip=(EditText) root.findViewById(R.id.user_tip);
                TextView res=(TextView) root.findViewById(R.id.result);
                String text= user_tip.getEditableText().toString();
                res.setText(text);
                user_tip.setText("");
            }
        });
        return root;

    }

}
