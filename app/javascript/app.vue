<template>
  <div id="app">
    <ul>
      <li v-for="competition in competitions" :key="competition.id">
        {{competition.name}}:{{competition.period_start}}〜{{competition.period_end}}
      </li>
    </ul>
  </div>
</template>

<script>
// axiosのモジュールをインポート
import axios from 'axios';
export default {
  data: function () {
    return {
      competitions: "competitions"
    }
  },
  mounted() {
    this.setCompetition();
  },
  methods:{
    // setCompetitionsメソッドを定義
    setCompetition: function(){
      // GETメソッドでapi/competitionsとしたとき
      axios.get('/api/competitions')
          // 成功したら、
      .then(response=>(
          // Axiosで呼び出したAPIの情報をcompetitionsに格納
          this.competitions = response.data
      ))
    }
  }

}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
