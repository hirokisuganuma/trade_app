import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button"
export default class extends Controller {
    static targets = ["td"]

    click() {
        var text = this.tdTarget.textContent.replace(/\n\s+/g, "\n").trim()
        // テキストエリアを作成して一時的に内容を格納
        var textarea = document.createElement("textarea");
        textarea.textContent = text;

        // ボディにテキストエリアを追加
        document.body.appendChild(textarea);

        // テキストエリアの内容を選択してクリップボードにコピー
        textarea.select();
        document.execCommand("copy");

        // テキストエリアを削除 ※コピーのテキストも構造上の欠陥で入ってしまうがツール上では無視されるので問題なし
        document.body.removeChild(textarea);
    }
}
