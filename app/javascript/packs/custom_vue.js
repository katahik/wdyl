import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import axios from 'axios';



document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        el: '#app',
        data: {
            items: "items"
        },
        mounted() {
            this.setItems();
        },
        methods: {
            // setCompetitionsメソッドを定義
            setItems: function () {
                // GETメソッドでapi/competitionsとしたとき
                axios.get('/api/items')
                    // 成功したら、
                    .then(response => (
                        // Axiosで呼び出したAPIの情報をcompetitionsに格納
                        this.items = response.data
                    ))
            },
        }
    })
})
