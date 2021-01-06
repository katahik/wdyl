<template>
  <div id="app">
    <ul>
      <li v-for="item in items" :key="item.id">
        {{item.name}}
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
      items:"items"
    }
  },
  mounted() {
    this.setItems();
  },
  methods:{
    // setCompetitionsメソッドを定義
    setItems: function(){
      // GETメソッドでapi/competitionsとしたとき
      // ここには、json形式になった@random_itemsがある(index.json.jbuilderで定義した)
      axios.get('/api/items')
          // 成功したら、
      .then(response=>(
          // Axiosで呼び出したAPIの情報をcompetitionsに格納
          this.items = response.data
      ))
    },
  }

}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
